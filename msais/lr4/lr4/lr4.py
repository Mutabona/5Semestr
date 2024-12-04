import numpy as np

def calculate_geometric_means(matrix):
    return np.prod(matrix, axis=1) ** (1 / matrix.shape[1])

def normalize_vector(vector):
    return vector / np.sum(vector)

def create_comparison_matrix(data):
    size = data.shape[0]
    matrix = np.zeros((size, size))
    for i in range(size):
        for j in range(size):
            matrix[i, j] = data[i] / data[j]
    return matrix

def calculate_alternative_priorities(data):
    alternative_priorities = {}
    for key, matrix in data.items():
        alt_priority = calculate_geometric_means(matrix)
        alternative_priorities[key] = normalize_vector(alt_priority)
    return alternative_priorities

# Матрица попарных сравнений для критериев
criteria_comparison = np.array([
    [1, 3, 1/3, 2],
    [1/3, 1, 1/4, 1/2],
    [3, 4, 1, 4],
    [1/2, 2, 1/4, 1],
])

# Вычисление и нормализация средних геометрических для критериев
priority_vector = normalize_vector(calculate_geometric_means(criteria_comparison))

# Данные ОС
alternatives = np.array([
    [5, 7, 5, 16],  # Оборудование A
    [7, 8, 5, 32],   # Оборудование B
    [5, 6, 9, 64]    # Оборудование C
])

# Составление матриц попарных сравнений для альтернатив
criteria = ["Стоимость", "Интерфейс", "Надежность", "Разрядность"]
matrices = {criteria[i]: create_comparison_matrix(alternatives[:, i]) for i in range(alternatives.shape[1])}

# Вычисление приоритетов для каждой альтернативы
alternative_priorities = calculate_alternative_priorities(matrices)

# Вектор приоритетов для критериев уровня 2
criteria_priorities = np.array([0.24, 0.09, 0.53, 0.14])

# Вектор приоритетов для альтернатив уровня 3
alternative_matrix = np.array([alternative_priorities[criterion] for criterion in criteria]).T

# Расчет итоговых оценок для альтернатив
final_scores = np.dot(alternative_matrix, criteria_priorities)

# Вывод итоговых оценок
print("Итоговые оценки вариантов:")
for i, score in enumerate(final_scores):
    print(f"Вариант {chr(65+i)}: {score:.3f}")

max_index = np.argmax(final_scores)

print(F"\nОптимальный: {chr(65+max_index)}")