#include <windows.h>
#include <stdio.h>

int num1 = 9;
int num2 = -5;
int sum = 0;
int diff = 0;

void Calculate() {
    sum = num1 + num2;
    diff = num1 - num2;
}

LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
    case WM_CREATE:
        Calculate();
        break;

    case WM_PAINT:
    {
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);

        char resultText[256];
        sprintf_s(resultText, sizeof(resultText), "%d", sum);
        TextOutA(hdc, 10, 10, "Сумма:", strlen("Сумма:"));
        TextOutA(hdc, 100, 10, resultText, strlen(resultText));
        sprintf_s(resultText, sizeof(resultText), "%d", diff);
        TextOutA(hdc, 10, 30, "Разность:", strlen("Разность:"));
        TextOutA(hdc, 100, 30, resultText, strlen(resultText));
        EndPaint(hwnd, &ps);
    }
    break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hwnd, msg, wParam, lParam);
    }
    return 0;
}

int main() {
    WNDCLASS wc = { 0 };
    wc.lpfnWndProc = WndProc;
    wc.lpszClassName = L"SumDiffApp";
    wc.hInstance = GetModuleHandle(NULL);

    if (!RegisterClass(&wc)) {
        MessageBoxA(NULL, "Ошибка регистрации окна!", "Ошибка", MB_ICONERROR);
        return 0;
    }

    HWND hwnd = CreateWindow(wc.lpszClassName, L"Win32 Приложение: Сумма и Разность",
        WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, 400, 200,
        NULL, NULL, wc.hInstance, NULL);

    if (hwnd == NULL) {
        MessageBoxA(NULL, "Ошибка создания окна!", "Ошибка", MB_ICONERROR);
        return 0;
    }

    ShowWindow(hwnd, SW_SHOW);
    UpdateWindow(hwnd);

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return (int)msg.wParam;
}
