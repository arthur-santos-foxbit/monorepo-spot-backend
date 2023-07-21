class Identity < ApplicationRecord
  validates :email, :cid, presence: true, uniqueness: true

  def to_json(options = {})
    { id:, email:, cid: }.to_json(options)
  end
end
