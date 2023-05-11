
main-target-types := qwe rty yui

main-targets-qwe := qwe1 qwe2 qwe3
main-targets-rty := rty1 rty2 rty3
main-targets-yui := yui1 yui2 yui3

main-targets := $(foreach type,$(main-target-types),$(main-targets-$(type)))

print-variable:
	@echo $(main-targets)

print-types:
	@echo $(main-target-types)


print-type-targets:
	@if [ "$(type)" = "qwe" ]; then \
		echo $(main-targets-qwe); \
	elif [ "$(type)" = "rty" ]; then \
		echo $(main-targets-rty); \
	elif [ "$(type)" = "yui" ]; then \
		echo $(main-targets-yui); \
	else \
		echo "Invalid type specified"; \
	fi