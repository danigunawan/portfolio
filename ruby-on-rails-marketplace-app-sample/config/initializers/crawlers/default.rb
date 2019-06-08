# begin
# 	System::Bot::Crawler.find_or_create_by(name:"default") do |t|
# 		t.long_name = "Default Niche Market" 
# 		t.path = "default"
# 		t.save
# 	end
# rescue ActiveRecord::StatementInvalid
# 	p 'Failed to load templates!'
# end