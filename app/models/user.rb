class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :ddd_phone, :ddi_phone, :phone, presence: true

  validates :email, uniqueness: true, on: %i[create update]

  validates :password, confirmation: { case_sensitive: false }, on: %i[create update]

  def full_name
    "#{first_name} #{last_name}"
  end

  def formatted_full_phone
    formatted_phone = phone.clone.insert(5, '-')
    "+#{ddi_phone} (#{ddd_phone}) #{formatted_phone}"
  end

  def unformatted_full_phone
    "#{ddi_phone}#{ddd_phone}#{phone}"
  end

  def age_in_days
    (Time.now.to_date - birthday).to_i
  end

  def age
    age_in_days / 365
  end

  def next_birthday
    today = Time.now.to_date
    year = today.year
    next_b = Date.new(year, birthday.month, birthday.day)
    return next_b if today < next_b

    year = today.next_year.year
    Date.new(year, birthday.month, birthday.day)
  end

  def last_birthday
    today = Time.now.to_date
    year = today.year
    last_b = Date.new(year, birthday.month, birthday.day)
    return last_b if today > last_b

    year = today.last_year.year
    Date.new(year, birthday.month, birthday.day)
  end

  # TODO: Delete after
  def self.to_test(user_id = nil)
    u = if user_id.present?
          User.where(id: user_id).first
        else
          User.first
        end

    unless u.present?
      puts "Not Found with provided user_id: #{user_id}"
      return nil
    end

    # curl -H "Content-Type: application/json" -X POST -d '{"email":"felipeejunges@hotmail.com","password":"12345"}' http://localhost:3000/api/v1/login

    puts "full_name: #{u.full_name}"
    puts "before format: #{u.unformatted_full_phone}"
    puts "formatted: #{u.formatted_full_phone}"
    puts "after format: #{u.unformatted_full_phone}"
    puts "age_in_days: #{u.age_in_days}"
    puts "age: #{u.age}"
    puts "next_birthday: #{u.next_birthday}"
    puts "last_birthday: #{u.last_birthday}"
    puts "inspect: #{u.inspect}"
    u
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  birthday        :date
#  email           :string
#  ddi_phone       :string
#  ddd_phone       :string
#  phone           :string
#  last_login      :datetime
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
