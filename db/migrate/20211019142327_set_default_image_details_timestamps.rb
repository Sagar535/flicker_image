class SetDefaultImageDetailsTimestamps < ActiveRecord::Migration[6.0]
  def change
    change_column_default :image_details, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :image_details, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
