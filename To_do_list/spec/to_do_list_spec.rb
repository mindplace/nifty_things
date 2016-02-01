require 'to_do_list'
require 'rspec'

describe ToDoList do 
   before :each do 
       @list = ToDoList.new
   end
   
   describe "new list" do 
       it "should initialize to an empty list" do
           @list.should be_an_instance_of ToDoList
       end
       it "should initialize to an empty list" do 
            @list.list.should eql []
       end
   end
end