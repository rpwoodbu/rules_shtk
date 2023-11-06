load("//:repositories.bzl", "shtk_dist_toolchain" )

_install = tag_class(
    attrs = {
        "name": attr.string(mandatory = True),
        "version": attr.string(),
        "sha256": attr.string(),
    },
)

def _impl(ctx):
    for mod in ctx.modules:
        for install in mod.tags.install:
            shtk_dist_toolchain(
                name = install.name,
                version = install.version,
                sha256 = install.sha256,
            )

dist = module_extension(
    implementation = _impl,
    tag_classes = {
        "install": _install,
    },
)
