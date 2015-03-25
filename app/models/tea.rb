class Tea < ActiveRecord::Base
  	belongs_to :user
  	belongs_to :tea_type
  	has_and_belongs_to_many :atts
	validates :name, presence: true
	validates :stock, presence: true
	validates :tea_type_id, presence: true
	validates :user_id, presence: true

	def self.search(search, user_id)
		
		@tea = Tea.select("name").where("teas.stock = ? and teas.user_id = ?", "In",user_id)

		if !search[:tea_type_id].blank?
			@tea = @tea.where("tea_type_id = ?",search[:tea_type_id])
		end
		
		if !search[:att].blank?
			@tea = @tea.joins("INNER JOIN atts_teas ON teas.id = atts_teas.tea_id").where("atts_teas.att_id in (?)",search[:att].split(","))
		end

		@tea = @tea.group("name").order("random()").first
	end

	def self.teaSort(searchParams, sortType, user_id)
		
		@teas = Tea.select("*").where("user_id = ?", user_id)

		if searchParams[:sort].blank?
			@teas = @teas.all
		else			
			@teas = @teas.order("#{searchParams[:sort]} #{sortType}")
		end

	end
end
