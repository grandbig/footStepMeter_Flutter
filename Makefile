# Flutter プロジェクト用 Makefile

.PHONY: help
help: ## このヘルプを表示します
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\\033[36m%-20s\\033[0m %s\\n", $$1, $$2}'

.PHONY: deps
deps: ## 依存関係をインストールします
	flutter pub get

.PHONY: generate
generate: ## コード生成を実行します（Freezed, JSON, Riverpod, Realm）
	dart run build_runner build --delete-conflicting-outputs

.PHONY: watch
watch: ## ファイル変更を監視してコード生成を自動実行します
	dart run build_runner watch

.PHONY: test-coverage
test-coverage: ## テストを実行してカバレッジレポートを生成します（自動生成ファイルを除外）
	flutter test --coverage
	lcov --remove coverage/lcov.info \
		"**/*.g.dart" \
		"**/*.freezed.dart" \
		"**/*.realm.dart" \
		"**/l10n/generated/**" \
		-o coverage/lcov_filtered.info \
		--ignore-errors unused
	@echo "✅ Coverage report generated at coverage/lcov_filtered.info"
	@echo "🧹 Generated files (.g.dart, .freezed.dart, .realm.dart, l10n/generated/) have been excluded from coverage"

.PHONY: test-coverage-html
test-coverage-html: test-coverage ## HTMLカバレッジレポートを生成してブラウザで開きます
	rm -rf coverage/html
	cd $(PWD) && genhtml coverage/lcov_filtered.info -o coverage/html --prefix $(PWD)/
	@echo "✅ HTML coverage report generated at coverage/html/index.html"
	@echo "🌐 Opening coverage report in browser..."
	@open coverage/html/index.html || echo "Please open coverage/html/index.html manually"