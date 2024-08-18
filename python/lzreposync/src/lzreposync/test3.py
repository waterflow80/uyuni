#  pylint: disable=missing-module-docstring

# TODO Remove this file (used only for illustration purposes and code review)
import updates_util
from updates_importer import UpdatesImporter

# update_info_xml = (
#     "cc162e424fa20219fa2c046a9c66c99281fa7908561aca9566fd58265c299f01-updateinfo.xml"
# )

updateinfo_file = updates_util.download_file("https://download.opensuse.org/update/leap/15.5/oss/repodata/0720d17f14b5ebe26403fda6358103cc8187df79bd7145d62fb71c9073cc1c77-updateinfo.xml.gz")

print(f"updateinfo_file: {updateinfo_file}")

channel_label = "test_channel"

notices = updates_util.get_updates(updateinfo_file)

patches_importer = UpdatesImporter(channel_label=channel_label, available_packages={})

patches_importer.import_updates(notices)
