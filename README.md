# Gomplate Docker

Continuously watch `/opt/gomplate` directory for change and render templates in `/opt/gomplate/template.d` with config in `/opt/gomplate/config.yaml` and/or context in `/opt/gomplate/context.yaml` or datasources in `/opt/gomplate/datasource.d`. The output file is a one to one mapping from the template with `/opt/gomplate/template.d` omitted, e.g. `/opt/gomplate/template.d/tests/test.yaml` will render as `/tests/test.yaml`.

Note that you can specify config and/or context or datasources. In case of datasources without config and context, the filename (without extension) will be the alias, e.g. `/opt/gomplate/datasource.d/secret.yaml` has alias `secret`.
