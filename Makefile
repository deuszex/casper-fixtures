prepare:
	rustup target add wasm32-unknown-unknown
	rustup component add clippy --toolchain ${PINNED_TOOLCHAIN}
	rustup component add rustfmt --toolchain ${PINNED_TOOLCHAIN}
	rustup component add rust-src --toolchain ${PINNED_TOOLCHAIN}

clippy:
	cargo clippy --all-targets --all

check-lint: clippy
	cargo fmt --all -- --check
format:
	cargo fmt --all

lint: clippy format
	
clean:
	cargo clean
