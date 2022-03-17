# frozen_string_literal: true

# The goal of this file is to be able to run
# ruby -r ./addressbook' -e 'puts AddressBook.new(project).to_json' | yq -t > # project\~
# And then load the project file with abook

require 'faker'
require 'json'
# # abook addressbook file
# [format]
# program=abook
# version=0.6.1
#
#

class AddressBookDocument
  attr_reader :project
  def initialize(project)
    @project = project
  end

  # GROUPS = [:infrastructure, :payments, :opensource]

  GROUPS = {
    infrastructure: [:engineer],
    payments: [:manager],
    opensource: [:student, :author]
  }

  def to_json
    header.merge([:alpha, :beta].map do |buddy|
      GROUPS.keys.map do |group|
        GROUPS[group].map do |actor|
          BookEntry.new(project, group, buddy)
          BookEntry.new(project, group, actor)
        end
      end
    end)
  end
  ACTORS = [:manager, :student, :author, :engineer]
  # project
  #   group
  #     actor
  #       buddy1
  #       buddy2
  def header
    # [format]
    {
      program: :abook,
      version: '0.6.1'
    }
  end
end


# nodoc
class BookEntry
  def initialize(project, group, actor)
    @project = project
    @group = group
    @actor = actor
  end

  def to_json(_)
    # [0]
    JSON.generate({
                    name: name,
                    email: email,
                    mobile: mobile,
                    nick: nick,
                    notes: notes,
                    anniversary: anniversary,
                    groups: groups,
                    custom1: custom1,
                    custom2: custom2,
                    custom3: custom3
                  })
  end

  def name
    Faker::Name.name
  end

  def email
    2.times.map do
      Faker::Internet.safe_email
    end.join(',')
  end

  def mobile
    Faker::PhoneNumber.cell_phone_in_e164
  end

  def nick
    @actor
  end

  def notes
    Faker::Lorem.words(number: 12).join(' ')
  end

  def anniversary
    Faker::Date.birthday
  end

  def groups
    @group
  end

  def custom1
    Faker::Crypto.sha1
  end

  def custom2
    Faker::Crypto.md5
  end

  def custom3
    Faker::Crypto.sha256
  end
end
