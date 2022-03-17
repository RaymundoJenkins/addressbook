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
# [0]
# name=Ben Safari
# email=x10000000000@icloud.com,x0000000000@protonmail.com
# mobile=+10000000000
# nick=student
# notes=I don't know.
# anniversary=1987-04-10
# groups=public
# custom1=0000000000000000
# custom2=00/00
# custom3=000

class AddressBookDocument
  # project
  #   group
  #     actor
  #       buddy1
  #       buddy2
  def to_json
    # [format]
    {
      program: :abook,
      version: 0.6.1
    }
end


# nodoc
class BookEntry
  def initialize(project, group, actor)
    @project = project
    @group = group
    @actor = actor
  end

  def to_json(_)
    JSON.generate({
                    name: name
                  })
  end

  def name
    Faker::Name.name
  end
end
