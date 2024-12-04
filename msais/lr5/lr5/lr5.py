import numpy as np
import matplotlib.pyplot as plt

a = 0
b = 1

trial_counts = [100, 500, 1000, 5000, 10000]
errors = []

def f(x):
    return np.sin(2*x*x+1)

# метод Монте-Карло
def monte_carlo_integration(a, b, N):
    random_points_x = np.random.uniform(a, b, N)
    function_values = f(random_points_x)
    integral = (b - a) * np.mean(function_values)
    std_dev = np.std(function_values)
    error = (b - a) * std_dev / np.sqrt(N)
    return integral, error

# Точное значение интеграла
from scipy.integrate import quad
exact_value, _ = quad(f, a, b)
print(f"Точное значение интеграла: {exact_value:.6f}")

# Вычисление интеграла и погрешности
for N in trial_counts:
    estimated_value, error = monte_carlo_integration(a, b, N)
    errors.append(error)
    print(f"N = {N}, вычисленное значение интеграла: {estimated_value:.6f}, погрешность: {error:.6f}")

# Построение графика
plt.figure(figsize=(12, 6))
plt.plot(trial_counts, errors, label='Погрешность', marker='o')
plt.xlabel('Количество испытаний')
plt.ylabel('Погрешность')
plt.title('График зависимости погрешности результата от числа испытаний')
plt.legend()
plt.grid(True)
plt.show()

final_estimation = estimated_value
final_error = error

print("\nИтоговое значение интеграла: {:.6f}".format(final_estimation))
print("Оценка погрешности: {:.6f}".format(final_error))