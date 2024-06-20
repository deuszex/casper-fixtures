build:
	cargo build --release

clippy:
	cargo clippy --all-targets --all

check-lint: clippy
	cargo fmt --all -- --check
format:
	cargo fmt --all

lint: clippy format
	
clean:
	cargo clean
