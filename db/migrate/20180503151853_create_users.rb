class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_name
      t.text :profile_picture
      t.string :full_name
      t.string :access_token

      t.timestamps
    end
  end
end
