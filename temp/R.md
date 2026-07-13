```bash
                              ●
                              │
                              ▼
                     App Launch
                              │
                              ▼
                  Read Local Storage
             onboarding_completed ?
                              │
                 ┌────────────┴────────────┐
                 │                         │
            [false / null]             [true]
                 │                         │
                 ▼                         ▼
          Show Onboarding             Show Home
                 │                         │
                 │                         │
         Skip / Finish                     │
                 │                         │
                 ▼                         │
   Save onboarding_completed = true        │
        to Local Storage                   │
                 │                         │
                 └────────────┬────────────┘
                              │
                              ▼
                   User uses application
                              │
                     ┌────────┴────────┐
                     │                 │
               Continue as Guest   Sign Up / Login
                     │                 │
                     │                 ▼
                     │         User Account Created
                     │                 │
                     │                 ▼
                     │      Do NOT sync onboarding
                     │        to backend server
                     │                 │
                     │                 ▼
                     │      Do NOT read onboarding
                     │       
                     │                 │
                     └────────┬────────┘
                              │
                              ▼
                 Continue using application
                 (Local Storage is source of truth)
                              │
                              ▼
                      Application Closed
                              │
                              ▼
                        Next App Launch
                              │
                              ▼
                   Read Local Storage
             onboarding_completed ?
                              │
                 ┌────────────┴────────────┐
                 │                         │
              [true]                  [false]
                 │                         │
                 ▼                         ▼
            Show Home              Show Onboarding
                 │                         │
                 └────────────┬────────────┘
                              │
                              ▼
                              ◎
```

```mermaid
flowchart TD

    A([Start])
    B[App Launch]
    C[Read Local Storage<br/>onboarding_completed]
    D{Completed?}

    E[Show Onboarding]
    F[User taps Skip / Finish]
    G[Save onboarding_completed = true<br/>to Local Storage]

    H[Show Home]

    I[User uses application]

    J{Authentication?}

    K[Continue as Guest]

    L[Sign Up / Login]
    M[User Account Created]

    N["Do NOT sync onboarding<br/>to backend"]

    O["Do NOT read onboarding<br/>from backend"]

    P["Continue using Local Storage<br/>as Source of Truth"]

    Q[Application Closed]

    R[Next App Launch]

    S[Read Local Storage]

    T{Completed?}

    U[Show Home]
    V[Show Onboarding]

    W([End])

    A --> B
    B --> C
    C --> D

    D -- No --> E
    D -- Yes --> H

    E --> F
    F --> G
    G --> H

    H --> I

    I --> J

    J -- Guest --> K
    J -- Login --> L

    K --> P

    L --> M
    M --> N
    N --> O
    O --> P

    P --> Q
    Q --> R
    R --> S
    S --> T

    T -- Yes --> U
    T -- No --> V

    U --> W
    V --> W
```

