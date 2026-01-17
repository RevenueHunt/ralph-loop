# Spec: [Feature/Component Name]

## Overview

<!-- Brief description of this feature/component -->
This specification defines [what this spec covers].

## Requirements

### Functional Requirements

1. **REQ-001**: [Requirement description]
2. **REQ-002**: [Requirement description]
3. **REQ-003**: [Requirement description]

### Non-Functional Requirements

1. **NFR-001**: [Performance/Security/etc requirement]
2. **NFR-002**: [Performance/Security/etc requirement]

## Data Model (if applicable)

<!-- Define data structures, schemas, or models -->
```typescript
interface Example {
  id: string;
  name: string;
  createdAt: Date;
}
```

## API Endpoints (if applicable)

### `GET /api/resource`

**Description**: Retrieve resources

**Response**:
```json
{
  "data": [],
  "total": 0
}
```

### `POST /api/resource`

**Description**: Create a new resource

**Request Body**:
```json
{
  "name": "string"
}
```

**Response**:
```json
{
  "id": "string",
  "name": "string"
}
```

## User Interface (if applicable)

<!-- Describe UI components and interactions -->

### Components

1. **ComponentName**: [Description]
   - Props: [list props]
   - Behavior: [describe behavior]

### User Flows

1. User navigates to [page]
2. User sees [content]
3. User clicks [action]
4. System responds with [response]

## Error Handling

| Error Case | Expected Behavior |
| ---------- | ----------------- |
| [Case 1]   | [Behavior]        |
| [Case 2]   | [Behavior]        |

## Testing Considerations

- [ ] Unit tests for [component]
- [ ] Integration tests for [flow]
- [ ] E2E tests for [scenario]

## Security Considerations

- [ ] [Security requirement 1]
- [ ] [Security requirement 2]

## Open Questions

<!-- List any unresolved questions or ambiguities -->
1. [Question 1]
2. [Question 2]
