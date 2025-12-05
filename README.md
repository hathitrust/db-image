## db-image

Docker image with MariaDB and HathiTrust database for testing,
and Ruby code for deriving and manipulating the data preserved
in this repo.

NOTE: the `convert_tinyint_to_bool` flag is set to `false` in the
database connections provided by `lib/database.rb`, meaning that it
is easy to assume that, for example, `ht_institutions.us` will contain
`false` values -- wrong! -- Ruby `0` is `true`. Use only `.zero?` or
`.positive?` when reasoning about these values.
You can blame the overloaded `ht_institutions.enabled` for this
sad state of affairs.

Note: the `mdp-lib` credentials (at the end of `sql/000_ht_schema.sql`)
should be used wherever possible. The `mdp-admin` account has write
permission and can be used for seeding the database where necessary.

*Under no circumstances should this image be used in a production
environment!*
