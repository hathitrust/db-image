## db-image

Docker image with MariaDB and HathiTrust database for testing.

Note: the `mdp-lib` credentials (at the end of `sql/000_ht_schema.sql`)
should be used wherever possible. The `mdp-admin` account has write
permission and can be used for seeding the database where necessary.

*Under no circumstances should this image be used in a production
environment!*
