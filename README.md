# casper-fixtures
Fixture builder for casper execution engine tests based on:
https://github.com/casper-network/casper-node/blob/release-1.5.6/execution_engine_testing/tests/src/lmdb_fixture.rs
integrating https://github.com/Fraser999/lmdb-shrinker.

Creates and shrinks lmdb database so that the state can be loaded back into the execution-test-engine. Test builder in use is generally `InMemoryWasmTestBuilder` but after fixture creation and loading it will load as `LmdbWasmTestBuilder`.

Developer might need to change self authored utility functions from
```
fn function_name<T: CLTyped + FromBytes>(
    builder: &WasmTestBuilder<InMemoryWasmTestBuilder>,
) -> T 
```
to accomodate the two different `WasmTestBuilder`s to 
```
fn function_name<T: CLTyped + FromBytes, S>(
    builder: &WasmTestBuilder<S>,
) -> T where
S: StateProvider + CommitProvider,
engine_state::Error: From<S::Error>,
S::Error: Into<execution::Error>
```

Create fixtures using the `generate_fixture` function that will create fixtures at `./fixtures/${generate_fixture_name_argument}/`.

`builder_from_global_state_fixture` will try to load state from the place `generate_fixture` created it at.


## Casper Versions
casper-engine-test-support = "7.0.1"
casper-execution-engine = { version = "7.0.1", features = ["test-support"] }
casper-types = { version = "4.0.0", default_features = false, features = ["datasize", "json-schema"] }
casper-hashing = "3.0.0"

These correspond to release 1.5.6 of the Casper-Node. Use to create pre-2.0.0 state fixtures, for migration tests from 1.x to 2.x versions.

## Reasons for this merged repo
- automate lmdb shrinking
- original work creates the fixtures in the "CARGO_MANIFEST_DIR", which causes third-party (out-of casper-node project) builds to be more easily lost/harder to find/harder to maintain.
- unifying makes the pipeline quicker and easier to manage.