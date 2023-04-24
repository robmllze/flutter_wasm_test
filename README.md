# Flutter, Rust and Wasm

### Installing Rust:

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

### Installing wasm-pack to compile Rust code into WASM code:

    curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
    nano ~/.bash_profile

Then add `export PATH="$PATH:$HOME/.cargo/bin"`

    wasm-pack --version

### Creating a new Rust library:

    cargo new <LIBRARY_NAME> --lib

### Creating a new function to import to Flutter:

Go to `src/lib.rs`, then replace with something like:

```rust
#[no_mangle]
pub extern "C" fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

### Configure Cargo.toml:

Add the following to `cargo.toml`

```toml
[lib]
crate-type = ["cdylib"]
[dependencies]
wasm-bindgen = "0.2"
```

### Building Rust code to WASM package:

    wasm-pack build --target web

Open the `pkg` folder and the compliked `.wasm` files should be there 

### Last steps:

Copy the `.wasm` files to the Flutter project's `web/` folder and check the Flutter code in this example project on how to load them.