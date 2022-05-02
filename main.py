import sqlite3
from flask import Flask, jsonify


def connection(query):
    with sqlite3.connect("animal.db") as con:
        cursor = con.cursor()
        result = cursor.execute(query)
        return result.fetchall()



app = Flask(__name__)
@app.route("/item/<int:id>")
def output_by_id(id):
    query = f"""
                SELECT 
                animals_new.id
                , outcomes.age_upon_outcome
                , `name`
                , `date_of_birth`
                , types.type
                , breeds.breed
                , color_first.color1
                , color_second.color2
                , outcome_subtypes.outcome_subtypes
                , outcome_types.outcome_type
                , outcomes.month
                , outcomes.year
                
                FROM animals_new
                
                LEFT JOIN outcomes ON animals_new.id = outcomes.id_animals
                LEFT JOIN outcome_subtypes ON outcomes.id_outcome_subtypes = outcome_subtypes.id
                LEFT JOIN outcome_types ON outcomes.id_outcome_types = outcome_types.id
                LEFT JOIN types ON animals_new.id_types = types.id
                LEFT JOIN breeds ON animals_new.id_breeds = breeds.id
                LEFT JOIN color_first ON animals_new.id_color_first = color_first.id
                LEFT JOIN color_second ON animals_new.id_color_second = color_second.id
                
                WHERE animals_new.id = {id}
   """


    result = connection(query)
    return jsonify(result)

# print(output_by_id(3))

if __name__ == "__main__":
    app.run(debug=True)
