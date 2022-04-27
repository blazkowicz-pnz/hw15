import sqlite3

def connection(query):
    with sqlite3.connect("animal.db") as con:
        cursor = con.cursor()
        result = cursor.execute(query)
        return result.fetchall()


def query_one():
    query = """
            SELECT * FROM animals
    """
    result = connection(query)
    return result

print(query_one())