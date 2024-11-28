// WindowsProject1.cpp : Определяет точку входа для приложения.
//

#include "framework.h"
#include "WindowsProject1.h"
int ak1 = 9;
int ak2 = 9;
int ak3 = 9;
int ak4 = 9;
int ak5 = 9;

#define MAX_LOADSTRING 100

// Глобальные переменные:
HINSTANCE hInst;                                // текущий экземпляр
WCHAR szTitle[MAX_LOADSTRING];                  // Текст строки заголовка
WCHAR szWindowClass[MAX_LOADSTRING];            // имя класса главного окна

// Отправить объявления функций, включенных в этот модуль кода:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);

// Прототипы дополнительных функций
void AddControls(HWND);
HWND hNum1, hNum2, hSum, hDiff;

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPWSTR    lpCmdLine,
    _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // Инициализация глобальных строк
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_WINDOWSPROJECT1, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Выполнить инициализацию приложения:
    if (!InitInstance(hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_WINDOWSPROJECT1));

    MSG msg;

    // Цикл основного сообщения:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int)msg.wParam;
}

//
//  ФУНКЦИЯ: MyRegisterClass()
//
//  ЦЕЛЬ: Регистрирует класс окна.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc = WndProc;
    wcex.cbClsExtra = 0;
    wcex.cbWndExtra = 0;
    wcex.hInstance = hInstance;
    wcex.hIcon = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_WINDOWSPROJECT1));
    wcex.hCursor = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wcex.lpszMenuName = NULL;
    wcex.lpszClassName = szWindowClass;
    wcex.hIconSm = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   ФУНКЦИЯ: InitInstance(HINSTANCE, int)
//
//   ЦЕЛЬ: Сохраняет маркер экземпляра и создает главное окно
//
//   КОММЕНТАРИИ:
//
//        В этой функции маркер экземпляра сохраняется в глобальной переменной, а также
//        создается и выводится главное окно программы.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
    hInst = hInstance; // Сохранить маркер экземпляра в глобальной переменной

    HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW & ~WS_CAPTION,
        CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

    if (!hWnd)
    {
        return FALSE;
    }

    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);

    return TRUE;
}

//
//  ФУНКЦИЯ: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  ЦЕЛЬ: Обрабатывает сообщения в главном окне.
//
//  WM_COMMAND  - обработать меню приложения
//  WM_PAINT    - Отрисовка главного окна
//  WM_DESTROY  - отправить сообщение о выходе и вернуться
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_COMMAND:
    {
        int wmId = LOWORD(wParam);
        // Разобрать выбор в меню:
        switch (wmId)
        {
        case IDM_EXIT:
            DestroyWindow(hWnd);
            break;
        case 1: {
            break;
        }
        default:
            return DefWindowProc(hWnd, message, wParam, lParam);
        }
    }
    break;
    case WM_PAINT:
    {
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hWnd, &ps);
        // TODO: Добавьте сюда любой код прорисовки, использующий HDC...
        int num1 = 9;
        int num2 = -5;
        int ak6 = 9;
        int ak7 = 9;
        int ak8 = 9;
        int ak9 = 9;
        int ak10 = 9;
        int sum = num1 + num2;
        int diff = num1 - num2;

        wchar_t sumStr[10], diffStr[10];
        _itow_s(sum, sumStr, 10);
        _itow_s(diff, diffStr, 10);

        SetWindowTextW(hSum, sumStr);
        SetWindowTextW(hDiff, diffStr);
        
        EndPaint(hWnd, &ps);
    }
    break;
    case WM_CREATE:
        AddControls(hWnd);
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Функция добавления элементов управления
void AddControls(HWND hWnd)
{
    CreateWindowW(L"Static", L"Номер в группе: ", WS_VISIBLE | WS_CHILD | SS_CENTER, 50, 50, 150, 20, hWnd, NULL, NULL, NULL);
    hNum1 = CreateWindowW(L"Static", L"9", WS_VISIBLE | WS_CHILD | SS_CENTER, 200, 50, 150, 20, hWnd, NULL, NULL, NULL);

    CreateWindowW(L"Static", L"Номер буквы: ", WS_VISIBLE | WS_CHILD | SS_CENTER, 50, 100, 150, 20, hWnd, NULL, NULL, NULL);
    hNum2 = CreateWindowW(L"Static", L"-5", WS_VISIBLE | WS_CHILD | SS_CENTER, 200, 100, 150, 20, hWnd, NULL, NULL, NULL);

    CreateWindowW(L"Static", L"Сумма:", WS_VISIBLE | WS_CHILD | SS_CENTER, 50, 150, 150, 20, hWnd, NULL, NULL, NULL);
    hSum = CreateWindowW(L"Static", L"", WS_VISIBLE | WS_CHILD | SS_CENTER, 200, 150, 150, 20, hWnd, NULL, NULL, NULL);

    CreateWindowW(L"Static", L"Разность:", WS_VISIBLE | WS_CHILD | SS_CENTER, 50, 200, 150, 20, hWnd, NULL, NULL, NULL);
    hDiff = CreateWindowW(L"Static", L"", WS_VISIBLE | WS_CHILD | SS_CENTER, 200, 200, 150, 20, hWnd, NULL, NULL, NULL);
}
