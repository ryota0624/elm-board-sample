function store(key, value) {
  localStorage.setItem(key, JSON.stringify(value));
}


function get(key) {
  const value = localStorage.getItem(key);
  
  if (value) {
    return JSON.parse(value)
  } else {
    return null;
  }
}

function isNull(v) {
  return v !== undefined && v !== null;
}

/**
 * @param {null|Thread} threadId 
 */
export function getThreadById(id) {
  return get(id);
}

/**
 * 
 * @param {Comment} threadId 
 */
export function getCommentsByThreadId(threadId) {
  const maybeThread = get(`${threadId}`);
  if (maybeThread) {
    const commentIds = maybeThread.commentIds;
    return commentIds.map(get).filter(v => isNull(v));
  } else {
    return [];
  }
}

/**
 * @param {Array<Thread>}
 */
const allThreadIdsKey = "allThreadIds";

export function getAllThread() {
  return (get(allThreadIdsKey) || []).map(get).filter(v => isNull(v));
}

export function storeThread(thread) {
  const id = Math.random().toString();
  const allKeys = get(allThreadIdsKey);

  if (allKeys) {
    store(allThreadIdsKey, allKeys.concat(id));
  } else {
    store(allThreadIdsKey, [id]);
  }

  store(id, Object.assign(thread, {id, commentIds: []}));
}

export class NotFoundThread extends Error {
  constructor(threadId) {
    super(`NotFoundThread: threadId ${threadId}`);
  }
}

export function storeComment(comment) {
  const id = Math.random().toString();
  const thread = get(comment.threadId);
  const createdAt = Date.now();
  if (thread) {
    const allCommentIds = thread.commentIds.concat(id);
    store(thread.id, Object.assign(thread, {commentIds: allCommentIds}));
    store(id, Object.assign(comment ,{id, createdAt}));
  } else {
    throw new NotFoundThread(comment.threadId);
  }
}