import numpy as np
import matplotlib.pyplot as plt

def f(x):
    return np.sin(2 * x**2 + 1)

a = 0
b = 1
N = 10000

# определение границ прямоугольной области
x_min, x_max = a, b
y_min, y_max = 0, 1  # максимальное значение sin(x) равно 1

# генерация случайных точек
random_points_x = np.random.uniform(x_min, x_max, N)
random_points_y = np.random.uniform(y_min, y_max, N)

# вычисление значений функции в случайных точках
function_values = f(random_points_x)

# подсчет точек под кривой
below_curve = random_points_y <= function_values
m = np.sum(below_curve)

# площадь области
S_rectangle = (x_max - x_min) * (y_max - y_min)

# вычисление площади под кривой
S_curve = S_rectangle * m / N

# оценка погрешности
std_dev = np.std(below_curve)
error = S_rectangle * std_dev / np.sqrt(N)

# построение графика
plt.figure(figsize=(12, 6))

# отображение точек
plt.scatter(random_points_x[below_curve], random_points_y[below_curve], color='green', s=1, label='Точки под кривой')
plt.scatter(random_points_x[~below_curve], random_points_y[~below_curve], color='red', s=1, label='Точки над кривой')

# отображение функции
x_values = np.linspace(a, b, 500)
y_values = f(x_values)
plt.plot(x_values, y_values, color='blue', label='f(x) = sin(2x^2 + 1)')

plt.xlabel('x')
plt.ylabel('y')
plt.title('Метод Монте-Карло: точки и кривая')
plt.legend()
plt.grid(True)

plt.show()
