import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
from copy import copy, deepcopy

def read_matrix(file):
    matrix = []
    for line in file:
        line = line.strip()
        if not line:
            break
        matrix.append(list(map(float, line.split())))
    return matrix

def read_matrix_from_file(filename):
    with open(filename, 'r') as file:
        return read_matrix(file)

def read_matrices_from_file(filename):
    matrices = []
    with open(filename, 'r') as file:
        while True:
            matrix = read_matrix(file)
            if not matrix:
                break
            matrices.append(matrix)
    return matrices


def draw_combined_graph(initial_nodes, weight_matrices):
    G = nx.Graph()
    node_positions = {}
    x_offset = 0
    y_offset = 0
    spacing = 6

    num_initial_nodes = len(initial_nodes[0])
    for i in range(num_initial_nodes):
        node_name = f'I_{i}'
        G.add_node(node_name, label=f'a{i + 1}')
        node_positions[node_name] = (x_offset, y_offset - i * spacing)

    previous_layer_nodes = [f'I_{i}' for i in range(num_initial_nodes)]
    x_offset += 2

    for idx, matrix in enumerate(weight_matrices):
        num_rows = len(matrix)
        num_cols = max(len(row) for row in matrix)

        if idx == len(weight_matrices) - 1:
            current_layer_nodes = [f'd{j + 1}' for j in range(num_rows)]
        else:
            current_layer_nodes = [f'N{idx}_{j}' for j in range(num_rows)]

        for i in range(num_rows):
            node_label = f'd{i + 1}' if idx == len(weight_matrices) - 1 else f'b{idx + 1}_{i + 1}'
            G.add_node(current_layer_nodes[i], label=node_label)
            node_positions[current_layer_nodes[i]] = (x_offset, y_offset - i * spacing)

        for i in range(num_rows):
            for j in range(num_cols):
                if matrix[i][j] != 0:
                    G.add_edge(previous_layer_nodes[j], current_layer_nodes[i], weight=matrix[i][j])

        previous_layer_nodes = current_layer_nodes
        x_offset += 3

    pos = {node: (x, y) for node, (x, y) in node_positions.items()}
    edge_labels = nx.get_edge_attributes(G, 'weight')
    labels = nx.get_node_attributes(G, 'label')

    plt.figure(figsize=(16, 8))
    nx.draw(G, pos, with_labels=True, labels=labels, node_size=700, edge_color='gray', linewidths=1, font_size=10)
    nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels, label_pos=0.85)
    plt.show()

filename = 'firstLevel.txt'
first_level = read_matrix_from_file(filename)
print(f"First level :")
for row in first_level:
    print(row)
print()

filename = 'input.txt'
matrices = read_matrices_from_file(filename)
for i, matrix in enumerate(matrices):
    print(f"Matrix {i + 1}:")
    for row in matrix:
        print(row)
    print()

draw_combined_graph(first_level, matrices)

weights = [first_level]

for i in range(0, len(matrices)):
    new_weights = []
    for row in matrices[i]:
        line = np.multiply(row, weights[i])
        new_weight = np.sum(line)/np.sum(weights[i])
        new_weights.append(new_weight)
    weights.append(new_weights)

answer = weights[len(weights) - 1] / sum(weights[len(weights) - 1])
for i in range(0, len(weights)):
    print(f"Weights {i + 1}:")
    print(weights[i])
print()

print("Answer: ")
print(answer)