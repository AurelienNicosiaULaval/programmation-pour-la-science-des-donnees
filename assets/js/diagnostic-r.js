(function () {
  "use strict";

  const domainMetadata = {
    fondamentaux: {
      label: "Objets et vecteurs",
      href: "ressources/mise-a-niveau-r.html#objets-vecteurs"
    },
    sous_ensembles: {
      label: "Sous-ensembles et valeurs manquantes",
      href: "ressources/mise-a-niveau-r.html#sous-ensembles-valeurs-manquantes"
    },
    tableaux: {
      label: "Tableaux et transformations",
      href: "ressources/mise-a-niveau-r.html#tableaux-transformations"
    },
    fonctions: {
      label: "Fonctions et contrôle",
      href: "ressources/mise-a-niveau-r.html#fonctions-controle"
    },
    scripts: {
      label: "Scripts, importation et aide",
      href: "ressources/mise-a-niveau-r.html#scripts-importation-aide"
    },
    diagnostic: {
      label: "Lecture d'erreurs et vérification",
      href: "ressources/mise-a-niveau-r.html#erreurs-verification"
    }
  };

  function initialiseDiagnostic() {
    const root = document.querySelector("[data-diagnostic-r]");

    if (!root) {
      return;
    }

    const form = root.querySelector("#diagnostic-r-form");
    const questions = Array.from(form.querySelectorAll(".diagnostic-question"));
    const progress = root.querySelector("#diagnostic-r-progress");
    const progressText = root.querySelector("#diagnostic-r-progress-text");
    const formAlert = root.querySelector("#diagnostic-r-form-alert");
    const result = root.querySelector("#diagnostic-r-result");
    const resultScore = root.querySelector("#diagnostic-r-result-score");
    const resultTitle = root.querySelector("#diagnostic-r-result-title");
    const resultMessage = root.querySelector("#diagnostic-r-result-message");
    const resultDomains = root.querySelector("#diagnostic-r-domain-results");
    const resultActions = root.querySelector("#diagnostic-r-result-actions");
    const copyButton = root.querySelector("#diagnostic-r-copy");
    const resetButton = root.querySelector("#diagnostic-r-reset");
    const totalQuestions = questions.length;
    let latestSummary = "";

    function answeredQuestions() {
      return questions.filter((question) => question.querySelector("input:checked"));
    }

    function updateProgress() {
      const answered = answeredQuestions().length;
      const percentage = Math.round((answered / totalQuestions) * 100);

      progress.value = answered;
      progress.max = totalQuestions;
      progress.setAttribute("aria-valuenow", String(answered));
      progressText.textContent = `${answered} question${answered > 1 ? "s" : ""} répondue${answered > 1 ? "s" : ""} sur ${totalQuestions}`;
      progress.style.setProperty("--diagnostic-progress", `${percentage}%`);
    }

    function clearQuestionState(question) {
      question.classList.remove("is-correct", "is-incorrect", "is-unanswered");
      question.querySelectorAll(".diagnostic-option").forEach((option) => {
        option.classList.remove("is-correct", "is-incorrect");
      });

      const feedback = question.querySelector(".diagnostic-feedback");
      feedback.hidden = true;
      feedback.querySelector(".diagnostic-feedback-status").textContent = "";
    }

    function gradeQuestion(question) {
      const selected = question.querySelector("input:checked");
      const correctValue = question.dataset.answer;
      const correctInput = question.querySelector(`input[value="${correctValue}"]`);
      const feedback = question.querySelector(".diagnostic-feedback");
      const status = feedback.querySelector(".diagnostic-feedback-status");
      const isCorrect = selected.value === correctValue;

      clearQuestionState(question);
      question.classList.add(isCorrect ? "is-correct" : "is-incorrect");
      correctInput.closest(".diagnostic-option").classList.add("is-correct");

      if (!isCorrect) {
        selected.closest(".diagnostic-option").classList.add("is-incorrect");
      }

      status.textContent = isCorrect ? "Réponse correcte. " : "Réponse à revoir. ";
      feedback.hidden = false;

      return isCorrect;
    }

    function buildDomainResults(domainScores) {
      resultDomains.replaceChildren();

      Object.entries(domainMetadata).forEach(([domainKey, metadata]) => {
        const domain = domainScores[domainKey];
        const row = document.createElement("tr");
        const domainCell = document.createElement("th");
        const scoreCell = document.createElement("td");
        const interpretationCell = document.createElement("td");
        const resourceLink = document.createElement("a");
        let interpretation = "À reprendre";

        if (domain.score === domain.total) {
          interpretation = "Base solide";
        } else if (domain.score >= 2) {
          interpretation = "À consolider";
        }

        domainCell.scope = "row";
        domainCell.textContent = metadata.label;
        scoreCell.textContent = `${domain.score} / ${domain.total}`;
        resourceLink.href = metadata.href;
        resourceLink.textContent = interpretation;
        interpretationCell.append(resourceLink);
        row.append(domainCell, scoreCell, interpretationCell);
        resultDomains.append(row);
      });
    }

    function buildActionList(weakDomains, score, category) {
      resultActions.replaceChildren();

      if (weakDomains.length > 0) {
        weakDomains.forEach((domainKey) => {
          const item = document.createElement("li");
          const link = document.createElement("a");
          const metadata = domainMetadata[domainKey];

          link.href = metadata.href;
          link.textContent = `Revoir: ${metadata.label}`;
          item.append(link);
          resultActions.append(item);
        });
      } else {
        const item = document.createElement("li");
        const link = document.createElement("a");

        link.href = "#verification-pratique";
        link.textContent = "Confirmer le résultat avec la vérification pratique";
        item.append(link);
        resultActions.append(item);
      }

      if (score < totalQuestions || category !== "ready") {
        const item = document.createElement("li");
        const link = document.createElement("a");

        link.href = "ressources/mise-a-niveau-r.html";
        link.textContent = "Ouvrir le parcours complet de mise à niveau";
        item.append(link);
        resultActions.append(item);
      }
    }

    function showResult(score, domainScores) {
      const weakDomains = Object.keys(domainScores).filter(
        (domainKey) => domainScores[domainKey].score < 2
      );
      let category = "priority";
      let title = "Remise à niveau recommandée";
      let message = "Votre résultat indique que plusieurs bases de R doivent être retravaillées avant le début du cours. Suivez d'abord les sections proposées ci-dessous, puis refaites le test sans consulter les réponses.";

      if (score >= 15 && weakDomains.length === 0) {
        category = "ready";
        title = "Bases prêtes pour commencer";
        message = "Votre résultat suggère que les bases minimales de R sont présentes. Faites maintenant la vérification pratique. Si elle exige la solution ou une aide importante, utilisez tout de même le parcours de consolidation.";
      } else if (score >= 11) {
        category = "consolidate";
        title = "Bases à consolider";
        message = "Votre résultat suggère des bases utilisables, mais encore inégales. Travaillez les domaines indiqués avant la première séance, puis confirmez vos acquis avec la vérification pratique.";
      }

      result.className = `diagnostic-result diagnostic-result--${category}`;
      resultScore.textContent = `${score} / ${totalQuestions}`;
      resultTitle.textContent = title;
      resultMessage.textContent = message;
      buildDomainResults(domainScores);
      buildActionList(weakDomains, score, category);

      latestSummary = [
        "Autodiagnostic R - STT-4230 / STT-6230",
        `Résultat global: ${score} / ${totalQuestions}`,
        `Interprétation: ${title}`,
        ...Object.entries(domainMetadata).map(([domainKey, metadata]) => {
          const domain = domainScores[domainKey];
          return `${metadata.label}: ${domain.score} / ${domain.total}`;
        })
      ].join("\n");

      result.hidden = false;
      result.setAttribute("tabindex", "-1");
      result.focus();
      result.scrollIntoView({ behavior: "smooth", block: "start" });
    }

    function copySummary() {
      const setCopyStatus = (message) => {
        copyButton.textContent = message;
        window.setTimeout(() => {
          copyButton.textContent = "Copier mon bilan";
        }, 2200);
      };

      if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(latestSummary).then(
          () => setCopyStatus("Bilan copié"),
          () => setCopyStatus("Copie impossible")
        );
        return;
      }

      const textarea = document.createElement("textarea");
      textarea.value = latestSummary;
      textarea.setAttribute("readonly", "");
      textarea.style.position = "fixed";
      textarea.style.opacity = "0";
      document.body.append(textarea);
      textarea.select();

      const copied = document.execCommand("copy");
      textarea.remove();
      setCopyStatus(copied ? "Bilan copié" : "Copie impossible");
    }

    form.addEventListener("change", (event) => {
      const question = event.target.closest(".diagnostic-question");

      if (question) {
        question.classList.remove("is-unanswered");
      }

      formAlert.hidden = true;
      updateProgress();
    });

    form.addEventListener("submit", (event) => {
      event.preventDefault();

      const unanswered = questions.filter(
        (question) => !question.querySelector("input:checked")
      );

      questions.forEach((question) => question.classList.remove("is-unanswered"));

      if (unanswered.length > 0) {
        formAlert.textContent = `Il reste ${unanswered.length} question${unanswered.length > 1 ? "s" : ""} sans réponse. Complétez-les avant de calculer le bilan.`;
        formAlert.hidden = false;
        unanswered.forEach((question) => question.classList.add("is-unanswered"));
        unanswered[0].querySelector("input").focus();
        unanswered[0].scrollIntoView({ behavior: "smooth", block: "center" });
        return;
      }

      formAlert.hidden = true;

      const domainScores = Object.keys(domainMetadata).reduce((scores, domainKey) => {
        scores[domainKey] = { score: 0, total: 0 };
        return scores;
      }, {});
      let score = 0;

      questions.forEach((question) => {
        const domainKey = question.dataset.domain;
        const isCorrect = gradeQuestion(question);

        domainScores[domainKey].total += 1;

        if (isCorrect) {
          score += 1;
          domainScores[domainKey].score += 1;
        }
      });

      showResult(score, domainScores);
    });

    resetButton.addEventListener("click", () => {
      form.reset();
      questions.forEach(clearQuestionState);
      formAlert.hidden = true;
      result.hidden = true;
      latestSummary = "";
      updateProgress();
      root.scrollIntoView({ behavior: "smooth", block: "start" });
      questions[0].querySelector("input").focus({ preventScroll: true });
    });

    copyButton.addEventListener("click", copySummary);
    updateProgress();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initialiseDiagnostic);
  } else {
    initialiseDiagnostic();
  }
})();
