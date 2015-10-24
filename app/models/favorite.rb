class Favorite < ActiveRecord::Base
  belongs_to :favuser,      class_name: "User"
  belongs_to :favmicropost, class_name: "Micropost"
end
