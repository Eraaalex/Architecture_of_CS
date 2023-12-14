#include <iostream>
#include <pthread.h>
#include <unistd.h>
#include <atomic>
#include <random>
#include <queue>
#include <stdio.h>

const int seed = 101;
std::mt19937_64 rnd(seed);

pthread_mutex_t mutex;
std::queue<int> buffer;
std::atomic<int> active_threads;

void printBuffer() {
    std::queue<int> copy_buf = buffer;
    std::cout << "Current buffer: ";
    while (!copy_buf.empty()) {
        std::cout << copy_buf.front() << " ";
        copy_buf.pop();
    }
    std::cout << std::endl;
}

void *sum(void *args) { // Sum two received values
    ++active_threads;
    int first = ((int *) args)[0];
    int second = ((int *) args)[1];
    printf("Sum: Values for current sum before delay: %d, %d\n", first, second);
    sleep(rnd() % 4 + 3);
    pthread_mutex_lock(&mutex);
    buffer.push(first + second);
    printf("Sum: (%d + %d) was pushed to buffer: %d\n", first, second, first + second);
    printBuffer();
    pthread_mutex_unlock(&mutex);
    --active_threads;
    return nullptr;
}

void *Checker(void *) { // Create new thread for sum two elements
    size_t id = 0;
    int data[40];
    pthread_t threads[20];
    while (buffer.size() >= 2 || active_threads > 0) {
        if (buffer.size() < 2) {
            continue;
        }
        pthread_mutex_lock(&mutex);
        data[id] = buffer.front();
        buffer.pop();
        data[id + 1] = buffer.front();
        buffer.pop();
        printf("Checker: two values: %d, %d\n", data[id], data[id + 1]);
        printBuffer();
        pthread_mutex_unlock(&mutex);
        pthread_create(&threads[id], NULL, sum, (void *) (data + id));
        ++id;

    }
    for (size_t i = 0; i < id; ++i) {
        pthread_join(threads[i], NULL);
    }
    return nullptr;
}

void *Adder(void *args) { // Put values in buffer (queue)
    ++active_threads;
    int element = *((int *) args);
    printf("Adder: New element: %d\n", element);
    sleep(rnd() % 7 + 1);
    pthread_mutex_lock(&mutex);
    printf("Adder: pushing element in buffer: %d\n", element);
    buffer.push(element);
    printBuffer();
    pthread_mutex_unlock(&mutex);
    --active_threads;
    return nullptr;
}

int main() {
    active_threads = 0;
    pthread_t add_threads[20];
    int values[20];
    for (int i = 0; i < 20; ++i) {
        values[i] = i + 1;
        pthread_create(&add_threads[i], NULL, Adder, (void *) (values + i));
    }
    pthread_t checker;
    pthread_create(&checker, NULL, Checker, nullptr);
    for (int i = 0; i < 20; ++i) {
        pthread_join(add_threads[i], NULL);
    }
    pthread_join(checker, NULL);
    printf("Main: final result sum: %d\n", buffer.front());
    return 0;
}