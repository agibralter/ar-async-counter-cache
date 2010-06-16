require 'spec_helper'

describe ArAsyncCounterCache::ActiveRecord do

  describe ArAsyncCounterCache::ActiveRecord::ClassMethods do
    it "should set async_counter_types" do
      Post.async_counter_types.should == {:user => "posts_count"}
      Comment.async_counter_types.should == {:user => "comments_count", :post => "count_of_comments"}
    end
  end
  
  context "callbacks" do

    before(:each) do
      @user = User.create(:name => "Susan")
    end
    
    it "should queue job" do
      Resque.should_receive(:enqueue).with(ArAsyncCounterCache::UpdateCountersJob, "Post", an_instance_of(Fixnum), :increment)
      @user.posts.create(:body => "I have a cat!")
    end
  end
end
