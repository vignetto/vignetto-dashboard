# The maximum number of parts a request can contain. Accepting to many part
# can lead to the server running out of file handles.

# Issue will be fixed in rack 1.7, counts nested forms as files.
# https://github.com/rack/rack/pull/814
# https://github.com/rack/rack/blob/8d21788798b521b97beb10047ebf593ddc0aaed2/lib/rack/utils.rb#L75

# Set to `0` for no limit.
Rack::Utils.multipart_part_limit = 0