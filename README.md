## How to build

```shell
cd oberror
make
```

`ob_error` will generated in `YOUR_OBERROR_PATH/build/bin` by default.

```shell
make install
```

`ob_error` will be installed in `/usr/local/bin` by default.

## How to use

```shell
ob_error --help
```

You can get the user manual by `--help` option.

## How to add error cause/solution

*This part is for developers.*

For example:

The ob error `4000` in `src/ob_errno.def` defined as

```shell
DEFINE_ERROR(OB_ERROR, -4000, -1, "HY000", "Common error");
```

If you want to add the cause and solution info, you can change the define as

```shell
DEFINE_ERROR(OB_ERROR, -4000, -1, "HY000", "Common error", "CAUSE", "SOLUTION");
```

And then regenerate the `src/lib/ob_errno.h`、`src/ob_errno.h` and `src/ob_errno.cpp` by

```shell
cd src
./gen_ob_errno.pl
```

Finally back to `oberror` dir and remake

```shell
cd ..
make && make install
```