class ChangeTaggingFieldName < ActiveRecord::Migration[5.1]
  def change

    remove_index :taggings, 'Instruction_id'
    remove_index :taggings, 'Tag_id'


    rename_column :taggings, :Instruction_id, :instruction_id
    rename_column :taggings, :Tag_id, :tag_id



    add_index :taggings, 'tag_id'
    add_index :taggings, 'instruction_id'
  end
end
