import * as LocalStorageAdapter from "./localStorageAdapter";
function isReplayComment(comment) {
  return typeof comment.targetCommentId === "string";
}
export function attach(app) {
  app.ports.emitRequestAllThreadPageResource.subscribe(() => {
      const allThread = LocalStorageAdapter.getAllThread();
      const threadWithCommentCount =　allThread
        .map((thread) =>  ({ thread, commentCount: LocalStorageAdapter.getCommentsByThreadId(thread.id).length}));
      requestAnimationFrame(() => {
        app.ports.receiveAllThreadPageResource.send(threadWithCommentCount);
      });
  });

  app.ports.emitRequestThreadPageResource.subscribe((id) => {
    const thread = LocalStorageAdapter.getThreadById(id);
    const comments = LocalStorageAdapter.getCommentsByThreadId(thread.id);
    const [firstComments, replayComments] = [comments.filter((comment) => !isReplayComment(comment)), comments.filter(isReplayComment)]
    const commentDtos = firstComments.map(firstComment => {
      return {firstComment, replayComments: replayComments.filter((c) => c.targetCommentId === firstComment.id) }
    });
    requestAnimationFrame(() => {
      app.ports.receiveThreadPageResource.send({thread, comments: commentDtos});
    });
  });

  app.ports.emitRequestCommentInputPageResource.subscribe(({threadId, commentId}) => {
      const thread = LocalStorageAdapter.getThreadById(threadId);
      const comments = LocalStorageAdapter.getCommentsByThreadId(threadId);
      const replayTarget = comments.filter((comment) => comment.id === commentId)[0];
      requestAnimationFrame(() => {
        app.ports.receiveCommentInputPageResource.send({thread, replayTarget : replayTarget ? replayTarget : null});
      });
  });

  app.ports.emitStoreThread.subscribe((thread) => {
    LocalStorageAdapter.storeThread(thread);  
    requestAnimationFrame(() => {
        app.ports.receiveFinishedStoreThread.send(null);
      })
  });

  app.ports.emitStoreComment.subscribe((comment) => {
    LocalStorageAdapter.storeComment(comment);  
    requestAnimationFrame(() => {
        app.ports.receiveFinishedStoreComment.send(null);
      })
  });
}