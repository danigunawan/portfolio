# namespace :market do
# 	desc "Syncing migration files from the market engine..."
#
# 	task :install => [:environment] do
#
# 	end
#
# 	namespace :listings do
# 		namespace :index do
# 			task :all => [:environment] do
# 				Listing.all.each do |i|
# 					p "Updating id: #{ i.id }"
# 					i.assign_to_categories
# 				end
# 			end
#
# 			task :latest => [:environment] do
# 				Listing.where("updated_at > ?", DateTime.now - 1.hours).each do |i|
# 					p "Updating id: #{ i.id }"
# 					i.assign_to_categories
# 				end
# 			end
# 		end
# 	end
#
# 	namespace :queries do
# 		task :destroy => [:environment] do
# 			system "rake jobs:clear"
# 			Query.destroy_all
# 			Category.all.each do |c|
# 				begin
# 					(c.class_reference_name.deconstantize + "::Query").constantize.destroy_all if c.class_reference_name
# 				rescue
# 					nil
# 				end
# 			end
# 		end
#
# 		task :build => [:environment] do
# 			# system "rake jobs:clear"
# 			Query.build_sub_queries
# 			system "rake jobs:workoff"
# 		end
#
# 		task :rebuild => [:environment] do
# 			system "rake market:queries:destroy"
# 			system "rake market:queries:build"
# 		end
#
# 		task :work => [:environment] do
# 			system "rake jobs:workoff"
# 		end
# 	end
# end
