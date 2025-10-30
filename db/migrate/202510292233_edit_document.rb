class EditDocument < ActiveRecord::Migration[7.1]
  def change
    # This migration is intentionally empty.
    # The file previously contained Cucumber step definitions by mistake.
    # Keeping a no-op migration here so `db:migrate` can run if this file is present.
  end
end