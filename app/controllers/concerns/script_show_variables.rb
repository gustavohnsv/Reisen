module ScriptShowVariables
  extend ActiveSupport::Concern
  private

  def set_show_variables
    # Assumimos que @script já foi definido pelo controller
    @item = @script.script_items.build
    @spend = @script.script_spends.build
    @owner = @script.user
    @participants = @script.script_participants.includes(:user).where.not(user_id: @owner&.id).or(
      @script.script_participants.where(user_id: nil)
    )
    @grouped_items = @script.script_items.order(date_time_start: :asc).group_by { |item| item.date_time_start&.to_date }
    
    # Pre-fetch all spends and group by date to avoid N+1
    @spends_by_date = @script.script_spends.includes(:user).group_by(&:date) || {}
  end

end