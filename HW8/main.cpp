#include <iostream>
#include <iomanip>
#include <limits>
#include <ctime>
#include <pthread.h>

struct Package {
    double *arrayA;  // A pointer to the beginning of the processing area
    double *arrayB;  // A pointer to the beginning of the processing area
    int threadNum;  // Stream number
    double sum;     // Result
};

unsigned int arrSize = 100000000;
//unsigned int arrSize = 500000000;
//unsigned int arrSize = 900000000;

double *A;  //vector a0...
double *B;  //vector b0...

//const int threadNumber = 1; // number of threads
// const int threadNumber = 2;
 const int threadNumber = 4; // number of threads
//const int threadNumber = 8;

// the starting function for threads
void *func(void *param) {
    // Востановление структуры
    Package *p = (Package *) param;
    p->sum = 0.0;
    for (unsigned int i = p->threadNum; i < arrSize; i += threadNumber) {
        p->sum += p->arrayA[i] * p->arrayB[i];
    }
    return nullptr;
}

int main() {
    double rez = 0.0; //для записи окончательного результата
    std::cout << "Input array size >=100000000\n";
    std::cin >> arrSize;
    if (arrSize < 100000000) {
        std::cout << "Incorrect size of vector (too small) = " << arrSize << "\n";
        return 1;
    }
    // vector A
    A = new double[arrSize];
    if (A == nullptr) {
        std::cout << "Incorrect size of vector = " << arrSize << "\n";
        return 1;
    }
    for (int i = 0; i < arrSize; ++i) {
        A[i] = double(i);
    }


    // vector B
    B = new double[arrSize];
    for (int i = 0; i < arrSize; ++i) {
        B[i] = double(arrSize - i);
    }
    pthread_t thread[threadNumber];
    Package pack[threadNumber];

    clock_t start_time = clock(); // start time

    // create threads
    for (int i = 0; i < threadNumber; i++) {

        pack[i].arrayA = A;
        pack[i].arrayB = B;

        pack[i].threadNum = i;
        pthread_create(&thread[i], nullptr, func, (void *) &pack[i]);
    }

    clock_t thread_started_time = clock(); // end time

    for (int i = 0; i < threadNumber; i++) {    // waiting for child threads to complete
        pthread_join(thread[i], nullptr);       // getting the result
        rez += pack[i].sum;
    }

    clock_t end_time = clock(); // end time

    std::cout << "Sum of squares = " << std::scientific <<
              std::setprecision(std::numeric_limits<double>::digits10 + 1) << rez << "\n";

    std::cout << "Number of threads = " << threadNumber << std::endl;
    std::cout << "Array size = " << arrSize << std::endl;
    std::cout << "Streams have started = " << thread_started_time - start_time << "\n";
    std::cout << "Time = " << end_time - start_time << "\n";

    delete[] A;
    delete[] B;
    return 0;
}
