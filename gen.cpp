#include <cstdio>
#include <random>

using namespace std;

constexpr int N = 2048;

float a[N][N], b[N][N];

int main()
{
    random_device rd;
    mt19937 mt(rd());
    uniform_real_distribution<float> urd(0, 1);

    for (auto &i : a)
        for (auto &j : i)
            j = urd(mt);

    for (auto &i : b)
        for (auto &j : i)
            j = urd(mt);

    FILE *fa = fopen("a.dat", "wb"), *fb = fopen("b.dat", "wb");
    fwrite_unlocked(a, sizeof(float), sizeof a / sizeof(float), fa);
    fwrite_unlocked(b, sizeof(float), sizeof b / sizeof(float), fb);
    fclose(fa);
    fclose(fb);
    return 0;
}
