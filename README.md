# DebugPrint Logstash Filter Plugin

The `debug_print` is a custom Logstash filter plugin designed to print event data to the standard output in JSON format. It is useful for debugging and inspecting event data during Logstash pipeline development.

## Features

- Outputs event data in JSON format.
- Supports optional tagging of output.
- Allows pretty-printing of JSON for better readability.

## Configuration Options

| Option   | Type    | Default | Description                                                                 |
|----------|---------|---------|-----------------------------------------------------------------------------|
| `tag`    | String  | `nil`   | Adds a custom tag to the output JSON.                                       |
| `pretty` | Boolean | `false` | Enables pretty-printing of the JSON output for better readability.          |

## Example Configuration

Below is an example of how to use the `debug_print` filter in a Logstash pipeline configuration:

- config file
```conf
# example.conf
input {
  stdin {}
}

filter {
  mutate {
    add_field => { "foo" => "bar" }
  }
  debug_print {
    tag => "debug_output"
    pretty => true
  }
  mutate {
    add_field => { "baz" => "quux" }
  }
}

output {
  stdout { codec => rubydebug }
}
```

- command
```bash
$ cd /tmp && git clone https://github.com/necoskijanen/logstash-filter-debug_print.git
$ echo "hello world" | sudo /usr/share/logstash/bin/logstash  -f /workspace/example.conf --path.plugins /tmp/logstash-filter-debug_print/lib
```

- output
```conf
# stdout
{
  "tag": "debug_output",
  "data": {
    "event": {
      "original": "hello world"
    },
    "@version": "1",
    "@timestamp": "2025-03-29T09:31:04.587228185Z",
    "message": "hello world",
    "host": {
      "hostname": "3b064c4f9911"
    },
    "foo": "bar"
  }
}
{
         "event" => {
        "original" => "hello world"
    },
      "@version" => "1",
    "@timestamp" => 2025-03-29T09:31:04.587228185Z,
       "message" => "hello world",
           "baz" => "quux",
          "host" => {
        "hostname" => "3b064c4f9911"
    },
           "foo" => "bar"
}
```

## Installation

### Option 1: Install as a Plugin

```bash
git clone https://github.com/necoskijanen/logstash-filter-debug_print.git
bin/logstash-plugin install --no-verify logstash-filter-debug_print/logstash-filter-debug_print-0.1.0.gem
```

### Option 2: Use Without Installation

You can use the plugin without installing it by specifying the file via the `--path.plugins` command-line argument:

```bash
git clone https://github.com/necoskijanen/logstash-filter-debug_print.git
logstash -f /path/to/pipeline.conf --path.plugins logstash-filter-debug_print/lib 
```

## License

This plugin is provided under the [Apache License 2.0](LICENSE).
