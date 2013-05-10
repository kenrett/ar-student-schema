require_relative '../../db/config'


class AgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.age > 3
      record.errors[attribute] << (options[:message] || "is not old enough")
    end
  end
end

class PhonevaliValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.phone.scan(/[0-9]/).length >= 10
      record.errors[attribute] << (options[:message] || "is not effing right, ya bastard.")
    end
  end
end


class Student < ActiveRecord::Base
  validates :email, :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,}
  validates :email, :uniqueness => true
  validates :birthday, :age => true
  validates :phone, :phonevali => true
  # validates :phone, :format => { :with => self.phone.scan(/[0-9]/)}

  def age
    now = Date.today
    age = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  end

  def name
    "#{first_name} #{last_name}"
  end
end


