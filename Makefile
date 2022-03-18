GROUP = 'infrastructure'

ACTOR = 'engineer'

PROJECT = 'rant.solutions'

ADDRESSBOOK_HEADER = '\# abook addressbook file'
ADDRESSBOOK_HEADER += "\n[format]"
ADDRESSBOOK_HEADER += "\nprogram=abook"
ADDRESSBOOK_HEADER += "\nversion=0.6.1"





SCRIPT = "puts BookEntry.new($(GROUP), $(ACTOR), $(PROJECT)).to_json('')"
default: SCRIPT
	@echo $(ADDRESSBOOK_HEADER)
	@for i in {0,1,2}; do \
	echo "\n"; \
	echo [$$i]; \
	ruby -r ./book_entry.rb -e $($^) | yq -t | sed 's/ = /=/g' | sed 's/"//g'; \
	done

.PHONY: SCRIPT
