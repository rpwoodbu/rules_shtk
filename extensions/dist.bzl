load("//:repositories.bzl", "shtk_dist_toolchain" )

_install = tag_class(
    attrs = {
        "version": attr.string(),
        "sha256": attr.string(),
    },
)

def _impl(ctx):
    installed = False
    for mod in ctx.modules:
        for install in mod.tags.install:
            if installed:
                fail("Multiple shtk toolchains not yet supported.")
            shtk_dist_toolchain(
                name = "shtk_hub",
                version = install.version,
                sha256 = install.sha256,
            )
            installed = True

dist = module_extension(
    implementation = _impl,
    tag_classes = {
        "install": _install,
    },
)
