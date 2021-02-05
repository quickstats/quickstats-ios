
.PHONY: format
format:
	swift-format format --in-place --recursive QuickStats

.PHONY:	beta
beta:
	fastlane beta

