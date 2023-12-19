'''
Love It? Star It! ⭐ https://github.com/omkarcloud/google-maps-scraper/
'''

# Función para leer las consultas del archivo
def read_queries_from_file(filename):
    queries_list = []
    with open(filename, 'r', encoding='utf-8') as file:  # Especificando la codificación aquí
        lines = file.readlines()
        for line in lines:
            if line.strip():
                keyword, max_results = line.strip().rsplit(',', 1)
                queries_list.append({
                    "keyword": keyword.strip(),
                    "max_results": int(max_results.strip()),
                })
    return queries_list

# Leer desde el archivo 'queries.txt' usando la codificación correcta
queries = read_queries_from_file('queries.txt')

number_of_scrapers = 1

