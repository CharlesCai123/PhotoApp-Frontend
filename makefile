.PHONY: clean_build build

LOCAL_DB_FILE := ~/data/test_postgres

clean_build:
    # Clean everything and build
	flutter clean
	dart pub get
	flutter pub get
	dart run build_runner build

build:
	dart run build_runner build
