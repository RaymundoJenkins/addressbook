GROUP ?= opensource

ACTOR ?= student

PROJECT ?= test.team

SCRIPT = "puts BookEntry.new('', '', '').to_json('')"
default: SCRIPT
	ruby -r ./book_entry.rb -e $($^) | yq -t | sed 's/ = /=/g' | sed 's/"//g'

.PHONY: SCRIPT
