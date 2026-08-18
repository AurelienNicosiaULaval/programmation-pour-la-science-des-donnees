<script>
document.querySelectorAll(".exercise-document").forEach((section) => {
  section.addEventListener("toggle", () => {
    if (!section.open) return;

    section.querySelectorAll("iframe[data-exercise-file]").forEach((frame) => {
      frame.src = frame.dataset.exerciseFile;
      frame.removeAttribute("data-exercise-file");
    });
  }, { once: true });
});
</script>
