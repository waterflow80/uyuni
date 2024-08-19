import re
import unittest
import psycopg2
from testcontainers.postgres import PostgresContainer

from spacewalk.server import rhnSQL

# container = PostgresContainer("postgres:16.3", port=5432)
# container.start()



# connection_url = container.get_connection_url()
# host = container.get_container_host_ip()
# port = container.get_exposed_port(5432)
# username = container.username
# password = container.password
# dbname = container.dbname


# print("CONNECTION URL: ", connection_url)
# print("DBNAME:", dbname)
# print("USER:", username)
# print("PASSWORD:", password)
# print("PORT:", port)
# dsndata.update(host=host, dbname=dbname, user=username, password=password, port=port)
#print(dsndata)
# conn = psycopg2.connect(
#     " ".join(
#         # pylint: disable-next=consider-using-f-string
#         "%s=%s" % (k, re.escape(str(v)))
#         for k, v in list(dsndata.items())
#         )
#     )

#conn = psycopg2.connect(**dsndata)


# cursor = conn.cursor()
# print("CONNECTION URL: ", connection_url)



class MyTestCase(unittest.TestCase):


    def test_postgres_version(self):
        dsndata = {
            "host": "localhost",
            "database": "susemanager",
            "username": "spacewalk",
            "password": "spacewalk",
            "port": 5432
        }

        rhnSQL.initDB(
            backend="postgresql",
            **dsndata
        )

        h = rhnSQL.prepare(
            """
            select version()"""
        )
        h.execute()
        res = h.fetchone()

        self.assertIsNotNone(res)


# container.stop()