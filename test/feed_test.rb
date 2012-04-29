require 'test_helper'

class FeedTest < MiniTest::Unit::TestCase
  def setup
		@config = YAML.load_file( File.join(File.dirname(__FILE__), 'test_config.yml') )['test']
		@connection = Amazon::MWS::Base.new(@config)
  end

  def test_submit_feed_non_stubbed
		response = @connection.submit_feed(:product_data,'Product',[{ 'sku'=>'234234234234', 'product-name'=>'name name name' }])
    assert_kind_of ResponseError, response    
  end

  def test_submit_flat_file_feed
    @connection.stubs(:post).returns(xml_for('submit_feed',200))
		response = @connection.submit_flat_file_feed(["234234234234\tname name name\t"],false)
    assert_kind_of SubmitFeedResponse, response
  end

  def test_submit_feed
  	@connection.stubs(:post).returns(xml_for('submit_feed',200)) 

    messages = [{
      'MessageID' => '1',
      'OperationType' => 'Update',
      'Product'=> {
        'SKU'=>'sku1324234324',
        'ItemPackageQuantity'=>'1',
        'NumberOfItems'=>'1',
        'StandardProductID'=>{'Type'=>'UPC', 'Value'=>'814digitstring'},
        'DescriptionData'=>{
          'Title'=>'title',
          'Brand'=>'brand',
          'Designer'=>'designer',
          'Description'=>'description', # max length 2000
          'BulletPoint'=>['bp1', 'bp2'], # max 5
          'ShippingWeight'=>{'unitOfMeasure'=>'LB', 'Value'=>'1'}, #TODO value is probably not the right term
          'MSRP'=>'5.43',
          'SearchTerms' => ['asdf1','asdf2'],
          'IsGiftWrapAvailable'=>'True',
          'IsGiftMessageAvailable'=>'True'
        },#DescriptionData
        'ProductData' => {
          'Clothing'=>{
            "VariationData"=> {
              "Parentage"=>"child", 
              "Size"=>"size",
              "Color"=>"color",
              "VariationTheme"=>"SizeColor"
            }, #VariationData
            'ClassificationData'=>{
              'ClothingType'=>'Accessory',
              'Department'=>['d1', 'd2'], # max 10 
              'StyleKeywords'=>['style1', 'style2'],  # max 10
              'OccasionAndLifestyle'=>['ol1', 'ol2'] # max 10
            }
          }#Clothing
        }#ProductData
      }#Product
    }]

		response = @connection.submit_feed(:product_data,'Product',messages)
    assert_kind_of SubmitFeedResponse, response
    assert_equal 2291326430, response.feed_submission.id
    assert_equal Feed::Enumerations::PROCESSING_STATUSES[:submitted], response.feed_submission.feed_processing_status
    assert_equal Feed::Enumerations::FEED_TYPES[:product_data], response.feed_submission.feed_type
  end
  
  def test_get_feed_submission_list_failure
    # Without stubbing, to test request code
    response = @connection.get_feed_submission_list
    assert_kind_of ResponseError, response  

    # With stubbing
    @connection.stubs(:get).returns(xml_for('error',401))
    response = @connection.get_feed_submission_list
    assert_kind_of ResponseError, response
  end

  def test_get_feed_submission_list_success
    @connection.stubs(:get).returns(xml_for('get_feed_submission_list',200))
    response = @connection.get_feed_submission_list
    assert_kind_of GetFeedSubmissionListResponse, response
  end

  def test_get_feed_submission_list_by_next_token
    @connection.stubs(:get).returns(xml_for('get_feed_submission_list_by_next_token',200))    
    response = @connection.get_feed_submission_list_by_next_token('234234234234234234')
    assert_kind_of GetFeedSubmissionListByNextTokenResponse, response
  end

  def test_get_feed_submission_count
    @connection.stubs(:get).returns(xml_for('get_feed_submission_count',200))    
    response = @connection.get_feed_submission_count
    assert_kind_of GetFeedSubmissionCountResponse, response
  end

  def test_cancel_feed_submissions
    @connection.stubs(:get).returns(xml_for('cancel_feed_submissions',200))    
    response = @connection.cancel_feed_submissions
    assert_kind_of CancelFeedSubmissionsResponse, response
  end

  def test_get_feed_submission_result
    @connection.stubs(:get).returns(xml_for('get_feed_submission_result',200))
    response = @connection.get_feed_submission_result('2342342342342342')
    assert_kind_of GetFeedSubmissionResultResponse, response    
  end

end
